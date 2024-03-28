function prompt.fishes
    set fishes \U1f41f \U1f420 \U1f421
    printf $fishes[(random 1 (count $fishes))]
end
