Graphic State Munging
======================
R scripts to extract relevant behavioral data from conditioning experiments conducted under [Graphic State](http://www.coulbourn.com/category_s/363.htm), a state notation language used by Coulbourn Instruments  
--------------------------------------------

The repository contains two subdirectories:

- [5ChoiceRT](https://github.com/jashu/graphic-state-munging/tree/master/5ChoiceRT): Contains a single script and function for use with data collected in the  [5-Choice Serial Reaction Time Task](http://www.coulbourn.com/product_p/h21-06m-fslash-r.htm)

- [lickometer](https://github.com/jashu/graphic-state-munging/tree/master/lickometer): R package for use with output generated by an [optical lickometer](http://www.coulbourn.com/product_p/h24-01r.htm). 

To install lickometer in R type:

    library(devtools)
    install_github("lickometer", "jashu", subdir="graphic-state-munging") 