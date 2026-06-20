#!/usr/bin/env nu

def main [
  --edit(-e) # Uses satty to edit the screenshot
] {
    let screenshot_dir = $"($env.HOME)/Pictures/screenshots/" + (date now | format date "%Y-%m")

    mkdir $screenshot_dir

    let image_path = $screenshot_dir
        | path join (date now | format date "%d-%m-%Y")

    let $final_path = $"($image_path)-{1..1000}.png"
        | str expand
        | skip while { path exists }
        | first

    grimblast -f copysave area $final_path 

    if $edit {
        # remove grimblast error line
        let image = $final_path | lines | first

        while (not ($image | path exists)) {
          sleep 0.5sec
        }

        # we overwrite the original
        (satty
            -o $image 
            --save-after-copy 
            -f $image)
    }
}
