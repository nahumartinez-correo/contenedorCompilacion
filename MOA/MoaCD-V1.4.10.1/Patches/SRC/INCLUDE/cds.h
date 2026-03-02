/***********************************************************/
/*														 */
/*   Typedefs used by central data server				*/
/*														 */
/***********************************************************/
#ifndef CDS_H
#define CDS_H
#ifndef CONNECTCB_H
#	include <x/conncb.h>
#endif
#ifndef CBTREE_H
#	include <cbtree.h>
#endif
#ifndef CDSLIMITS_H
#	include <cdslmts.h>
#endif
#ifndef DECMATH_H
#	include <decmath.h>
#endif

#define	FNAME_MAX	TBLEN		/* max length of table name */

/* 8 is a cbtree limit */
#define INDEX_NAME_MAX	ALTIDXLEN
#define CHUNK_SIZE(recsize) (((unsigned)(recsize + 512) >> 9) << 9)
#define SMALL_CHUNK(recsize) (((recsize + 64) >> 6) << 6)

#define INDEX_TABLE 1
#define FIELDS_TABLE 2

typedef struct LOCK_STRUCT
{
	struct LOCK_STRUCT	*next;
	struct LOCK_STRUCT	*prev;
	short  flags;				/* INUSE or not */
	struct connectcb *user;			/* who owns this lock */
	long   record_displacement;		/* displacement in base file */
	                                    /* OR pointer to pending_key */
} lock_struct;
/** lock_struct.flags values are: */
/* GL_INUSE = 1 */
#define AN_UPDATE_LOCK 2
#define EXCLUSIVE	4
#define A_READ_LOCK 8
#define A_KEY_LOCK  16
#define UNLOCK_PENDING 32
#define D_KEY_LOCK  64

#ifndef CMFIELD_H
#	include <cmfield.h>
#endif

#pragma pack (push, 2)
typedef struct
{
	unsigned char  appl_id;
	unsigned char  type;
	unsigned short field_id;
	unsigned short length;
	char		*value;		/* pointer to field value or null */
	char	*name;
	char 	modifier;		/* for index elements */
} FIELD_DEF;
enum scan_direction {d_unknown=0, d_forward, d_descending};

typedef struct STACK_TYP {
	short type;
	unsigned short obj_len;	/* or application number */
	union {
		int obj_int;
		char *str_loc;
		int	field_id;
		decwork *decimal;
	} object;
	byte  dimension;
	boolchar is_member;
	unsigned short sub1, sub2;	/* meaningless if dimension is zero */
	unsigned short field_id;	/* field id number */
	struct SELECTCB *context; /* pointer to server side context control block */
	short length_in_index;
	byte  index_position;
	unsigned char  fld_type;		/* field data type	*/
} operand;

#pragma pack (pop)
typedef struct Tab {
	struct Tab	*next;
	struct Tab	*prev;
	short  flags;					/* INUSE or not */
#define	NOW_OPEN	2
	unsigned long finder;				/* for debugging */
#define	 TABLE_TAG	0xCAFE0AAA
	char   name[FNAME_MAX + 4 + 1];	/*name of table as known by client*/
	char   internal_name[9];	/* internal name of table */
	byte	 table_number;		/*ID of table as known in recovery log*/
	boolchar	allow_del;
	boolchar	allow_new_field;
	short req_fields;
	FIELD_DEF *required_fld;	/* points to first element of field_def array*/	
	int	idx_fd;				/* index file descriptor */
	int	dat_fd;				/* base file descriptor */
	lock_struct *llhead;	/* lock list */
	struct connectcb	*excl_lk, *update_lk;	/* table locks */
	bool	wrote_index;	/* to indicate that flush is needed */
	bool	wrote_base;	/* to indicate that flush is needed */
	bool	made_index; /* during table opens */
	char	index_name[16];
	char	file_name[16];
	long	idx_size;	/* size to alloc for index */
	long	dat_size;	/* size to alloc for base file */
	byte	tbl_opts;	/* misc options associated w/ the table */
#define	STD_INIT	1
	byte	index_count;		/* number of indexes on this table */
	struct	Index	*index_list;
	long	buff_size;		/* rt buffer size for read/writing w/ cds */
	unsigned short   minimum_record_size;
	short	lock_sleep;			/* rt lock sleep before retry */
	short	lock_retry;			/* rt number of retries when lock encountered */
} Table;

#define TABLE_STRUCT

typedef struct pending_key {
	struct pending_key	*next;
	struct pending_key	*prev;
	short  flags;				/* INUSE or not */
	struct connectcb *user;			/* who owns this lock */
	struct Index  *idx;
	char   key[4];			/* variable length */
} pending_key;

typedef struct	Index {
	unsigned short key_len;
	byte	key_elements;
	byte	number;
	boolchar	unique;
	boolchar	allow_key_change;	/* allow this key to change in updates? */
	boolchar	sparse_no_add;		/* don't insert into index if true */
	char	name[ALTIDXLEN+1];
	unsigned	matched;
	long	highest; /* current highest key value assigned for generated key */
	FIELD_DEF *key_def;	/* points to first element of key_def array*/
	pending_key	*pending_head;	/* pending unique keys */
	void	*pending_free;
	struct btcommo index_type;
} Index;

/* global_var Table file_tab[]; */
global_var Table	*Table_list, *Table_free_list;
global_var	int	Tables_Open;
global_var char Ok[];

typedef struct PROJECTION
{
	struct PROJECTION	*next;
	struct PROJECTION	*prev;
	short  flags;						/* INUSE or not */
	byte	appl;		/* item application */
	byte	resp_appl;	/* appl number to use in response */
	byte	data_type;	/* item data type */
	byte	agg_type;	/* aggregate function id */
	index	item;		/* item number */
	index	resp_item;	/* item number to use in response */
	struct SELECTCB *context; /* source subcontext in join, or null in simple*/
	void	*fn_value;	/* field val or aggregate value */
} PROJECTION;

#ifndef	CDS_MAX_STMT_OPTIONS
#define CDS_MAX_STMT_OPTIONS 2
#endif
//# define CDS_CURSOR_FETCH_BEHAVIOUR 0			see cdsmacro.h
#define SELECT_TAG	0xCAFE0A01
#define verify_table_ptr(ptr) assert(ptr->finder == TABLE_TAG)
typedef struct SELECTCB
{
  struct  SELECTCB	  *next;		/* chain to list				 */
  struct  SELECTCB	  *prev;		/* chain to list				 */
  short		flags;
  unsigned long	finder;				/* should contain SELECT_TAG	*/
  char	name[CNTXTLEN+1];			/* context name */
  boolchar	in_progress;			/* scan in progress flag 			*/
  boolchar	  scan_started;			/* scan started with find first or last */
  boolchar	  force_first;			/* force find first of last on next fetch */
  boolchar	scan_cancelled;			/* scan cancelled by client */
  boolchar	aggregate;				/* true if aggregates in projection */
  boolchar	tmp_aggregate;			/* true if aggregates in tmp projection */
  boolchar	key_holes;				/* true if trailing parts in search key */
  boolchar	not_from_user;			/* true if scan queued, false=rebuild keys */
  boolchar	in_batch;			/* true if delete_all or update_all */
  char	uniqueness;				/* project unique ?*/
  char	tmp_uniqueness;			/* tmp project unique ? */
  long		agg_count;				/* number of records qualified with agg */
  lock_struct  *lock;				/* nil when current record not	  */
									/* locked for update				*/
  struct  connectcb *user;
  struct PROJECTION	*projection;	/* may be null if all fields desired */
  struct PROJECTION	*tmp_projection;	/* projection for cds_project function */
  char	*criteria;					/* may be null pointer if no criteria*/
  operand *varstack;				/* parsed criteria expression variables */
  operand *var_next;
  char	  *opstack;					/* parsed criteria expression operators */
  char	  *op_next;
  short	varidx;
  boolchar need_and;
  boolchar need_or;
  int option[CDS_MAX_STMT_OPTIONS];
  char	*buffer;					/* the retrieved data buffer		*/
  char	*save_buffer;				/* pointer to the space */
  char	*project_buffer;			/* holds projection response */
  char	*prev_project_buffer;		/* holds previous projection response */
  char	*tmp_key;					/* Temp 'FindXXX' key			   */
  char	*low_key;					/* low search key			   */
  char	*high_key;					/* high search key			   */
  char	*holy_low_key;					/* low search key			   */
  char	*holy_high_key;					/* high search key			   */
  unsigned short low_key_length, high_key_length;
  boolchar highpart[MAX_KEY_FIELDS];
  boolchar lowpart[MAX_KEY_FIELDS];
  boolchar	some_field_in_index;
  boolchar	all_fields_in_index;
  boolchar	have_record;			/* in join sub context */
  boolchar	have_instance;			/* in unique projection context */
  boolchar	preserve;				/* in outer joins */
  boolchar	matched_out;			/* in outer joins */
  enum scan_direction	order;
  Table *table;						/* pointer to the table description */
  struct fndset	*record_set;		/* used by Find_n */
  short skipped;					/* number of records skipped by Find_n */
  									/*  skipped is never less than -1 */
  enum find_n_direction
  {
  	NO_DIRECTION,
  	FORWARD_DIRECTION,
  	BACKWARD_DIRECTION
  } prev_find_n_direction;
  byte    fetch_again_direction;	/* used when no scan started and fetch_again is called */
  byte	  idx_number;				/* index used for this context */
  Index	 *index_used;		/* pointer may be good only inititally */
  addr	  prev_position;			/* for dereferencing fields in record */
  struct  SELECTCB *join_super;		/* nil unless this is a sub-context */
  struct  SELECTCB **join;			/* array of pointers to contexts */
  									/*  on which this context depends */

  uword   btoptype;     /* CBTREE operation type */
  char   *btkey;        /* search key for operation */
  long    btloc;        /* data file record location */
  long    next_btloc;   /* data file record location */
  bool    found_but_no_change;
  bool 	no_possible_matches;
  int cursor_state;		// meaningful only if option[CDS_CURSOR_FETCH_BEHAVIOUR] == CDS_ANSI_SQL_CURSOR_BEHAVIOR
#define CDS_BEFORE_FIRST 0
#define CDS_AT_FIRST 1
#define CDS_AFTER_FIRST 2
#define CDS_AT_LAST 8
#define CDS_AFTER_LAST 16
  int index_records_scanned, base_records_scanned;
} cdsselect;

typedef	struct	field_id {
	unsigned	char	appl;
	unsigned	short	fld;
}	field_id;
									/* is the pointer to this struct */
#define SELECT_STRUCT_DEFINED 1
global_var Connectcb *The_Server;

extern int flflush(int fd);
extern int RunOS;
extern int Explain;   // optimization explaination level
extern HANDLE OutFH;
#endif
