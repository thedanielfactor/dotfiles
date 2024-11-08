function mcs {
  model_prompt="$*"
  magic-cli suggest "$model_prompt"
}

function mcf {
  model_prompt="$*"
  magic-cli search "$model_prompt"
}

function mca {
  model_prompt="$*"
  magic-cli ask "$model_prompt"
}
