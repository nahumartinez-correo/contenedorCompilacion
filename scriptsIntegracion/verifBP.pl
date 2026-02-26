#!/usr/bin/perl

# Script de verificación de headers mejorado para Mosaic
# Lee la ubicación del MOAPROJ desde el registro de Windows

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

#Verifica si el header del archivo es correcto
sub verificaSingleStep{
  local $Archivo = @_[0];
  #local @IdTipo = split(/,/,@_[1]);
  open ARCH , "<$Archivo";
  while ($Linea = <ARCH>) {
    chop($Linea);
    if ($Linea =~ /singlestep/i) {
        return 1;
        last;
    }
  }
  close <ARCH>;
  return 0;
}

#Analiza cada archivo, si el archivo debe analizarse
#entonces ejecuta el proceso de analisis del header del mismo
sub verificaArchivo {
  local $Archivo = @_[0];
  #filtra los archivos con extensiones sin analisis
  if ($Archivo =~ /\FLD$/i) {
    return;
  }

  $encontre = &verificaSingleStep($Archivo);
  if ($encontre==1){
     print "Verificando $Archivo ... --> Tiene Single Step\n";
  }
}

        #########################################################
        #               Inicio programa principal               #
        #########################################################
        if (@ARGV) {
                 $PROY = shift(@ARGV);
        }
        else {
          print "No se especifico un proyecto valido";
          exit 0;
        }

        while (@ARGV) {
          # Usar la ubicación dinámica del MOAPROJ
          $verif = "$MOAPROJ_PATH\\$PROY\\".shift(@ARGV);
          &verificaArchivo($verif);
        }

