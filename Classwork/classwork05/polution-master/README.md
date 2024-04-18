This fork reimplements the original program logic generalizing portions of the code and adding additional functionality.

    CLIPS> (load "pollution.clp")
    :###########~%%%%%!!!!!!!*****************$@
    TRUE
    CLIPS> (reset)
    CLIPS> (run)
    For which measurements will values be given? (ph solubility spectroscopy colour smell specific_gravity radioactivity) ph smell
    What is the pH? (0 - 14) 2
    What is the smell? (none choking vinegar) choking
    Is there contamination at manhole 12? (yes no) yes
    The source of contamination is warehouse 2.
       The contaminate could be Hydrochloric acid.
       Potential risks: 
          skin burns
          asphyxiation
    CLIPS> 

Readme from the original repository:

# find-the-polution-causing-element-and-it-s-warehouse-with-CLIPS
##### Expert System project for my undergraduate class: Knowledge Systems.

###### Starring: NASA's CLIPS 

#### Project: 
A chemical company has a problem locating the source of chemical infections at its plant. The goal is to model the expert system with all the dynamic knowledge and given some measurements as input to find the element responsible for the polution and locate its warehouse. 

### Colaborated with:
- [Andreas Agapitos](https://github.com/andreasagap)
