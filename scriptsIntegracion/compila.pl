#!/usr/bin/perl

# Script de compilación mejorado para Mosaic
# Lee la ubicación del MOAPROJ desde el registro de Windows

# use strict;
# use warnings;

# Función para obtener la ubicación del MOAPROJ desde el registro
sub get_moaproj_path {
    my $moaproj_path = "";
    
    # Intentar leer desde el registro de Windows
    my $reg_query = `reg query "HKEY_LOCAL_MACHINE\\SOFTWARE\\Mosaic\\MOAPROJ" /v "Path" 2>nul`;
    if ($reg_query =~ /Path\s+REG_SZ\s+(.+)/) {
        $moaproj_path = $1;
        $moaproj_path =~ s/^\s+|\s+$//g; # Trim whitespace
    }
    
    # Si no está en el registro, intentar con HKEY_CURRENT_USER
    if (!$moaproj_path) {
        $reg_query = `reg query "HKEY_CURRENT_USER\\SOFTWARE\\Mosaic\\MOAPROJ" /v "Path" 2>nul`;
        if ($reg_query =~ /Path\s+REG_SZ\s+(.+)/) {
            $moaproj_path = $1;
            $moaproj_path =~ s/^\s+|\s+$//g; # Trim whitespace
        }
    }
    
    # Si no está en el registro, usar la variable de entorno MOAPROJ
    if (!$moaproj_path) {
        $moaproj_path = $ENV{MOAPROJ};
    }
    
    # Si no hay variable de entorno, usar la ubicación por defecto
    if (!$moaproj_path) {
        $moaproj_path = "C:\\MOAPROJ";
        print "ADVERTENCIA: No se encontró la ubicación del MOAPROJ en el registro.\n";
        print "Usando ubicación por defecto: $moaproj_path\n";
        print "Para configurar la ubicación, ejecute:\n";
        print "reg add \"HKEY_LOCAL_MACHINE\\SOFTWARE\\Mosaic\\MOAPROJ\" /v \"Path\" /t REG_SZ /d \"$moaproj_path\" /f\n\n";
    }
    
    return $moaproj_path;
}

# Obtener la ubicación del MOAPROJ
my $MOAPROJ_PATH = get_moaproj_path();
print "Usando MOAPROJ en: $MOAPROJ_PATH\n\n";

$proyecto = $ARGV[0];
if ($proyecto eq "") {
        die "No se especifico el proyecto\n";
}
if ($ARGV[1] eq "") {
        die "No se especifico ningun archivo para compilar\n";
}
system("pwd >temp.aux");
open(AUXFILE,"<temp.aux");
$Linea = <AUXFILE>;
$_ = $Linea;
close(AUXFILE);
unlink("temp.aux");
if ($Linea =~ /moaproj\/$proyecto/i) {
#if (/$proyecto/){
        #Todo bien
} else {
        die "No se encuentra dentro del path del proyecto\n";
}

$linea_comandoIni = "bc -n$proyecto -s -v -I.\\src\\include";
print "$linea_comandoIni\n";
if ($ARGV[1] eq "T") {
        $Verifica = "N";
        $i = 2;
} else {
        $Verifica = "S";
        $i = 1;
}
system("cd >raiz");
open(RAIZ,"raiz") || PrintLog("ERROR (No se pudo obtener el directorio raiz del proceso\n",1);
$DirRaiz = <RAIZ>;
chomp ($DirRaiz);
close (RAIZ);
unlink("raiz");
print "\n\n";
$DirSrcCSR = "e:\\moa\\src\\include";

#
# Subo en 1 el build de la version compilada
#
open DSC, "<.\\src\\lib\\main\\DSC";
open DSC_TEMP, ">.\\src\\lib\\main\\DSC.tmp";

while ($linea = <DSC>) {
 if ($linea =~ /BuildVersion/) {
   chomp($linea);

   $linea =~ s/BuildVersion//;
   $linea =~ s/\"//g;
   $linea =~ s/^\s+//s;   # trim annoying leading whitespace
   $linea =~ s/\s+$//s;   # trim annoying trailing whitespace

   $linea = $linea + 1;
   $BuildVersion = $linea;
   $linea = "BuildVersion        \"$linea\"\n";
 }
 print DSC_TEMP $linea;
}
close DSC;
close DSC_TEMP;
unlink(".\\src\\lib\\main\\dsc");
system("ren .\\src\\lib\\main\\DSC.tmp DSC");

# Usar la ubicación dinámica del MOAPROJ para el script importa.pl
$linea_comando = "perl \"$MOAPROJ_PATH\\importa.pl\" $proyecto .\\src\\lib\\main\\DSC";
#print "comando: ".$linea_comando."\n";
print "Generando Build de la version ($BuildVersion)\n";
system($linea_comando);
sleep(10);
#
# Fin cambio de build de version
#

while ($ARGV[$i] ne "") {
        #Cambio el caracter / del path por el \
        $file2Comp = $ARGV[$i];
        if ($file2Comp =~ /\//) {
                $file2Comp =~ s/\//\\/g;
        }

        # Usar la ubicación dinámica del MOAPROJ
        $dirIncluir = "-I$MOAPROJ_PATH\\$proyecto";
        #paso los elementos al array para obtener el path del archivo
        @valores = split(/\\/,$file2Comp);
        for ($k=0;$k<=$#valores-1;$k++) {
                $dirIncluir = $dirIncluir."\\@valores[$k]";
        }
        $linea_comando = #$linea_comando.
                                         "$linea_comandoIni $dirIncluir -I$DirSrcCSR $ARGV[$i] >>zResultado 2>&1";

    #print "$linea_comando\n";
        $i ++;

        #Cambio el dir de trabajo al path del archivo
        #system ("cd $dirTrabajo");
        print "Compilando ... $file2Comp\n";
        system($linea_comando);
        sleep(2);
}


if ($Verifica eq "S") {
        # Usar la ubicación dinámica del MOAPROJ para el script verif
        system("\"$MOAPROJ_PATH\\verif.bat\" $proyecto");
}

system ("cd $DirRaiz");


#$retval = system("find \"ERROR: Can't open\" zResultado");
#$retval = system("find \"Unknown object compile\" zResultado");
system("grep \"ERROR: Can't open\" zResultado");
system("grep \"Unknown object compile\" zResultado");
system("grep \"649: The data dictionary is locked by another user\" zResultado");

