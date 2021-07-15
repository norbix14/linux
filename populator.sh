#!/usr/bin/env bash

######################################################################

populate () {
  local wd=$(pwd)
  local ext="txt"
  local file=""
  local pyfile="datagen.py"
  local records=20

  if [[ $1 == "" ]]; then
    echo "Es necesario el nombre de la carpeta"
    echo "== Modo de uso =="
    echo "populate <foldername> <filename> <extension> <records>"
    echo "<foldername>: nombre de la carpeta contenedora"
    echo "<filename>: nombre del archivo que contendra los datos"
    echo "<extension>: txt o json"
    echo "<records>: cuantos registros falsos queres agregar"
    return 1
  fi

  echo "Comienzo de minado de datos falsos"
  echo "START: $(date)"

  if [ -d "$wd/$1" ]; then
    echo "El directorio < $1 > ya existe"
    echo "Los nuevos archivos se agregaran aqui"
  else
    mkdir $1
  fi

  if [[ $3 == "" ]]; then
    ext="txt"
    echo "No se especifico ningun formato para los datos"
    echo "Defaul: txt"
  else
    case $3 in
      "") ext="txt" ;;
      json) ext="json" ;;
      txt) ext="txt" ;;
      *) ext="txt"
    esac
  fi

  if [[ $2 == "" ]]; then
    file="fakedata.$ext"
    if [ -f "$wd/$1/$file" ]; then
      echo "< $file > ya existe"
    else
      echo "Era necesario el nombre del archivo"
      echo "No te preocupes, se creo uno por ti"
      echo "Lo podes buscar como < $file >"
      touch "$1/$file"
    fi
  else
    file="$2.$ext"
    if [ -f "$wd/$1/$file" ]; then
      echo "El archivo < $file > ya existe"
    else
      touch "$1/$file"
    fi
  fi

  if [[ $4 == "" ]]; then
    records=20
  else
    local rec=$4
    if [[ $rec =~ ^[+-]?[0-9]*$ ]]; then
      records=$rec
    fi
  fi

  if [[ $records =~ ^[+-]?[0]$ ]]; then
    records=0
    echo "Ningun dato fue agregado"
  else
    echo "Los nuevos datos fueron sumados a los ya existentes"
    if [[ $ext == "txt" ]]; then
      local data="$(py $wd/$pyfile $records $ext)"
      local dest="$wd/$1/$file"
      echo "# Datos falsos de prueba" >> "$dest"
      echo "# Elementos agregados: $records" >> "$dest"
      echo $data >> "$dest"
    fi
    if [[ $ext == "json" ]]; then
      local data="$(py $wd/$pyfile $records $ext)"
      local dest="$wd/$1/$file"
      echo "{$data}," >> "$dest"
    fi
  fi

  echo "========================="
  echo "Directorio: $1"
  echo "Nombre del archivo: $file"
  echo "Extension del archivo: $ext"
  echo "Registros agregados: $records"
  echo "PID del programa: $$"
  echo "========================="

  echo "END: $(date)"

  return 0
}
