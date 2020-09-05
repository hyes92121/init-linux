#!/usr/bin/env bash

## Uncomment to disable git info
#POWERLINE_GIT=0

__powerline() {
    # Colorscheme
    readonly RESET='\[\033[m\]'
    readonly COLOR_CWD='\[\033[0;36m\]' # cyan
    readonly COLOR_GIT='\[\033[0;33m\]' # yellow
    readonly COLOR_SUCCESS='\[\033[0;32m\]' # green
    readonly COLOR_FAILURE='\[\033[0;31m\]' # red 
    
    # add new colors 
    readonly COLOR_TIME='\[\033[0;91m\]' # red
    readonly COLOR_USER='\[\033[4;35m\]' # purple
    readonly COLOR_HOST='\[\033[0;35m\]' # purple

    # Symbols for git. Some symbols need powerline fonts 
    # to be showed correctly
    readonly SYMBOL_GIT_BRANCH='⑂'
    readonly SYMBOL_GIT_MODIFIED='*'
    readonly SYMBOL_GIT_PUSH='↑'
    readonly SYMBOL_GIT_PULL='↓'

    # Show different command prompt based on user kernel
    # Darwin -> MacOS
    # Linux  -> Ubuntu, Fedora, CentOS etc. 
    # *      -> Others (e.g. SunOS, FreeBSD)
    if [[ -z "$PS_SYMBOL" ]]; then
      case "$(uname)" in
          Darwin)   PS_SYMBOL='';;
          Linux)    PS_SYMBOL='$';; 
          *)        PS_SYMBOL='%';;
      esac
    fi

    # Prompt if the previous command returns an error code 
    if [[ -z "$PS_ERROR_SYMBOL" ]]; then
      case "$(uname)" in
          Darwin)   PS_ERROR_SYMBOL='';;
          Linux)    PS_ERROR_SYMBOL='$';;
          *)        PS_ERROR_SYMBOL='%';;
      esac
    fi

    __git_info() { 
        [[ $POWERLINE_GIT = 0 ]] && return # disabled
        hash git 2>/dev/null || return # git not found
        local git_eng="env LANG=C git"   # force git output in English to make our work easier

        # get current branch name
        local ref=$($git_eng symbolic-ref --short HEAD 2>/dev/null)

        if [[ -n "$ref" ]]; then
            # prepend branch symbol
            ref=$SYMBOL_GIT_BRANCH$ref
        else
            # get tag name or short unique hash
            ref=$($git_eng describe --tags --always 2>/dev/null)
        fi

        [[ -n "$ref" ]] || return  # not a git repo

        local marks

        # scan first two lines of output from `git status`
        while IFS= read -r line; do
            if [[ $line =~ ^## ]]; then # header line
                [[ $line =~ ahead\ ([0-9]+) ]] && marks+=" $SYMBOL_GIT_PUSH${BASH_REMATCH[1]}"
                [[ $line =~ behind\ ([0-9]+) ]] && marks+=" $SYMBOL_GIT_PULL${BASH_REMATCH[1]}"
            else # branch is modified if output contains more lines after the header line
                marks="$SYMBOL_GIT_MODIFIED$marks"
                break
            fi
        done < <($git_eng status --porcelain --branch 2>/dev/null)  # note the space between the two <

        # print the git branch segment without a trailing newline
        printf " $ref$marks"
    }

    ps1() {
        # Check the exit code of the previous command and display different
        # colors in the prompt accordingly. 
        if [ $? -eq 0 ]; then
            local symbol="$COLOR_SUCCESS $PS_SYMBOL $RESET"
        else
            local symbol="$COLOR_FAILURE $PS_ERROR_SYMBOL $RESET"
        fi

        local cwd="$COLOR_CWD\w$RESET"
        # Bash by default expands the content of PS1 unless promptvars is disabled.
        # We must use another layer of reference to prevent expanding any user
        # provided strings, which would cause security issues.
        # POC: https://github.com/njhartwell/pw3nage
        # Related fix in git-bash: https://github.com/git/git/blob/9d77b0405ce6b471cb5ce3a904368fc25e55643d/contrib/completion/git-prompt.sh#L324
        if shopt -q promptvars; then
            __powerline_git_info="$(__git_info)"
            local git="$COLOR_GIT\${__powerline_git_info}$RESET"
        else
            # promptvars is disabled. Avoid creating unnecessary env var.
            local git="$COLOR_GIT$(__git_info)$RESET"
        fi
        
        # Emulate new line
        PS_LINE=`printf .. '- %.0s' {1..200}`
        PS_FILL=${PS_LINE:0:$COLUMNS}
        PS_INFO="$COLOR_USER\u$RESET@$COLOR_HOST\h$RESET"
        
        # Currently only supports miniconda environments
        if [ ! -z "$CONDA_DEFAULT_ENV" ]; then
            virenv="(${CONDA_DEFAULT_ENV##*/})"
            PS_INFO="$virenv$PS_INFO"
        else
            PS_INFO=$PS_INFO
        fi

        if [ ! -z "$VIRTUAL_ENV" ]; then
            virenv="(${VIRTUAL_ENV##*/})"
            PS_INFO="$virenv$PS_INFO"
        else
            PS_INFO=$PS_INFO
        fi

        PS_TIME="\[\033[\$((COLUMNS-10))G\] $COLOR_TIME[\t]"
        PS1="${PS_FILL}\[\033[0G\]$PS_INFO:$cwd$git$PS_TIME\n${RESET}$symbol"

    }

    PROMPT_COMMAND="ps1${PROMPT_COMMAND:+; $PROMPT_COMMAND}"
}

__powerline
unset __powerline











