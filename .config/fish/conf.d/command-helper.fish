### COMMAND-HELPER ###

# Helper function to execute commands with feedback
function _execute_command
    set -l intended_command $argv[1]
    set -l actual_command $argv[2]
    set -l args $argv[3..-1]

    echo "command-helper: intended command recognized. Passing through as '$intended_command'"
    echo ""
    command $actual_command $args
end

# pwd command aliases
function owd
    _execute_command pwd pwd $argv
end
function pw
    _execute_command pwd pwd $argv
end

# z command aliases
function zdot
    _execute_command "z dot" "z dot" $argv
end

# clear command aliases
function ckr
    _execute_command clear clear $argv
end
function cl
    _execute_command clear clear $argv
end
function cr
    _execute_command clear clear $argv
end
function lear
    _execute_command clear clear $argv
end
function cpear
    _execute_command clear clear $argv
end
function ckear
    _execute_command clear clear $argv
end
function claer
    _execute_command clear clear $argv
end
function clea
    _execute_command clear clear $argv
end
function srow
    _execute_command stow stow $argv
end
function sriw
    _execute_command stow stow $argv
end
function syow
    _execute_command stow stow $argv
end
function syiw
    _execute_command stow stow $argv
end
function dpt
    _execute_command dot dot $argv
end

function powd
    _execute_command pwd pwd $argv
end
