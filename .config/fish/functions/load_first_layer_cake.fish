function load_first_layer_cake
  FIRST=(ls ~/.layer_cakes/$argv*.fish | head -n1)
  echo "--------------------------"
  echo "potential $argv layer cakes: "
  echo (ls ~/.layer_cakes/$argv*.sh | sed "s/^/--  /")
  if [ ! -e "$FIRST" ]; then
    echo "no layer cake found for $argv - Generating development version"
    load_layer_cake $argv vmm development
    FIRST=(ls ~/.layer_cakes/$argv*.fish | head -n1)
  fi
  source $FIRST
end

