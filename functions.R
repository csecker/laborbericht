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
# Sind die Laborparameter in einem eindimensionalen Array ueber die Zeit, sodass sie wir hier angesteuert werden koennten?

# Funtion schneller Anstieg 

schnellAnstieg <- function(param, anstiegGrenze) {
  for(i in 0:length(param)) {
    if(param[i+1] - param[i] > anstiegGrenze) { 
      return cat('Achtung! ', param, 'ploetzlich angestiegen.', sep='')
    }
  }
}

# Funtion schneller Abfall

schnellAbfall <- function(param, abfallGrenze) {
  for(i in 0:length(param)) {
    if(param[i+1] - param[i] < anstiegGrenze) {
      return cat('Achtung! ', param, 'ploetzlich abgefallen.', sep='')
    }
  }
}
