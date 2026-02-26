#!/usr/bin/perl

# Script de importación mejorado para Mosaic
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
        die "No se especifico ningun archivo para importar\n";
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
$indice = 1;
while ( $ARGV[$indice] ne "") {
        $linea_comando = "";
        if ($ARGV[$indice] =~ /fld/i) {
                $linea_comando = "impfld -n$proyecto -v -I$MOAPROJ_PATH\\$proyecto\\src\\include $ARGV[$indice] >>zResultado 2>&1";
        }
        if ($ARGV[$indice] =~ /apl/i) {
                $linea_comando = "impapl -n$proyecto -v -I$MOAPROJ_PATH\\$proyecto\\src\\include $ARGV[$indice] >>zResultado 2>&1";
        }
        if ($ARGV[$indice] =~ /bit/i) {
                $linea_comando = "impbit -n$proyecto -v -I$MOAPROJ_PATH\\$proyecto\\src\\include $ARGV[$indice] >>zResultado 2>&1";
        }
        if ($ARGV[$indice] =~ /csr/i) {
                $linea_comando = "impcsr -n$proyecto -v -I$MOAPROJ_PATH\\$proyecto\\src\\include $ARGV[$indice] >>zResultado 2>&1";
        }
        if ($ARGV[$indice] =~ /dsc/i) {
                $linea_comando = "impdsc -n$proyecto -v -I$MOAPROJ_PATH\\$proyecto\\src\\include $ARGV[$indice] >>zResultado 2>&1";
        }
        if ($ARGV[$indice] =~ /icn/i) {
                $linea_comando = "impicn -n$proyecto -v -I$MOAPROJ_PATH\\$proyecto\\src\\include $ARGV[$indice] >>zResultado 2>&1";
        }
        if ($ARGV[$indice] =~ /mnb/i) {
                $linea_comando = "impmnb -n$proyecto -v -I$MOAPROJ_PATH\\$proyecto\\src\\include $ARGV[$indice] >>zResultado 2>&1";
        }
        if ($ARGV[$indice] =~ /mnu/i) {
                $linea_comando = "impmnu -n$proyecto -v -I$MOAPROJ_PATH\\$proyecto\\src\\include $ARGV[$indice] >>zResultado 2>&1";
        }
        if ($ARGV[$indice] =~ /pat/i) {
                $linea_comando = "imppat -n$proyecto -v -I$MOAPROJ_PATH\\$proyecto\\src\\include $ARGV[$indice] >>zResultado 2>&1";
        }
        if ($ARGV[$indice] =~ /pdm/i) {
                $linea_comando = "imppdm -n$proyecto -v -I$MOAPROJ_PATH\\$proyecto\\src\\include $ARGV[$indice] >>zResultado 2>&1";
        }
        if ($ARGV[$indice] =~ /pic/i) {
                $linea_comando = "imppic -n$proyecto -v -I$MOAPROJ_PATH\\$proyecto\\src\\include $ARGV[$indice] >>zResultado 2>&1";
        }
        if ($ARGV[$indice] =~ /plb/i) {
                $linea_comando = "impplb -n$proyecto -v -I$MOAPROJ_PATH\\$proyecto\\src\\include $ARGV[$indice] >>zResultado 2>&1";
        }
        if ($ARGV[$indice] =~ /pmb/i) {
                $linea_comando = "imppmb -n$proyecto -v -I$MOAPROJ_PATH\\$proyecto\\src\\include $ARGV[$indice] >>zResultado 2>&1";
        }
        if ($ARGV[$indice] =~ /pmu/i) {
                $linea_comando = "imppmu -n$proyecto -v -I$MOAPROJ_PATH\\$proyecto\\src\\include $ARGV[$indice] >>zResultado 2>&1";
        }
        if ($ARGV[$indice] =~ /tag/i) {
                $linea_comando = "imptag -n$proyecto -v -I$MOAPROJ_PATH\\$proyecto\\src\\include $ARGV[$indice] >>zResultado 2>&1";
        }
        if ($ARGV[$indice] =~ /udo/i) {
                $linea_comando = "impudo -n$proyecto -v -I$MOAPROJ_PATH\\$proyecto\\src\\include $ARGV[$indice] >>zResultado 2>&1";
        }

        system($linea_comando);
        $indice ++;
}


# Usar la ubicación dinámica del MOAPROJ para el script verif
system("\"$MOAPROJ_PATH\\verif.bat\" $proyecto");
system("grep \"ERROR: Can't open\" zResultado");

