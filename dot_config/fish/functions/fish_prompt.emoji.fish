function fish_prompt.emoji
    set emoji \U1f41f \U1f420 \U1f421
    printf $emoji[(random 1 (count $emoji))]
end
