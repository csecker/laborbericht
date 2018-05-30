# Funktion Grenzwerte

# Funktion fuer Grenzwert ueberschritten

grenzwertUeber <- function(param, obereGrenze) {
  if(param > obereGrenze) {
    return cat('Achtung! Grenzwert', param, 'ueberschritten', sep='')
    }
}

# Funktion fuer Grenzwert unterschritten

grenzwertUnter <- function(param, untereGrenze) {
  if(param < untereGrenze) {
    cat('Achtung! Grenzwert', param, 'unterschritten', sep='')
    }
}

# Funktionen ploetzliche Veraenderung
# hier muessten die Werte ueber die Zeit also array gespeichert sein.

# Funtion schneller Anstieg 

schnellAnstieg <- function(param, anstiegGrenze) {
  for(i in 0:length(param)) {
    if(param[i+1] - param[i] > anstiegGrenze) { 
      return cat('Achtung! ', param, 'ploetzlich angestiegen.')
    }
  }
}

# Funtion schneller Abfall

schnellAbfall <- function(param, abfallGrenze) {
  for(i in 0:length(param)) {
    if(param[i+1] - param[i] < anstiegGrenze) {
      return cat('Achtung! ', param, 'ploetzlich abgefallen.')
    }
  }
}
