# quick fzf based dotfile navigation

function fzfdots()
{
    DOTFILE=$(git -C ~/dots ls-files | fzf)
    echo "Opening ~/dots/$DOTFILE"
    nvim ~/dots/$DOTFILE
}
