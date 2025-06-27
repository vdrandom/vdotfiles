function gdf
    git diff $argv | command diff-so-fancy | command less --tabs=4 -RSFX
end
