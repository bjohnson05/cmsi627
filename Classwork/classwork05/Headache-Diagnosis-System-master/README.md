This fork reimplements the original program logic generalizing portions of the code and adding additional functionality.

    CLIPS> (load headache.clp)
    +%%%%%!!!*+**+**+**+**+*+!**$$$$
    TRUE
    CLIPS> (reset)
    CLIPS> (run)
    
    Welcome to the Headache Medical Diagnosis System
    
    Patient's name: Fred
    Patient's gender: (male female) male
    
    Does Fred have blurred vision? (yes no) no
    Does Fred have depression? (yes no) yes
    Does Fred have trouble focusing? (yes no) no
    Does Fred have light sensitivity? (yes no) no
    Does Fred have trouble sleeping? (yes no) no
    Does Fred feel numbness in body parts? (yes no) no
    Does Fred have dizziness? (yes no) no
    Does Fred have vomiting or an upset stomach? (yes no) no
    Does Fred feel fatigued? (yes no) no
    Does Fred have a fever? (yes no) no
    Does Fred have trouble speaking and understanding? (yes no) yes
    Does Fred have trouble walking? (yes no) no
    Does Fred have bladder or bowel control problems? (yes no) no
    Does one side of Fred's face droop when he tries to smile? (yes no) no
    Does Fred's arm drift downward when raising both his arms? (yes no) no
    
    Headache Symptoms Analyzed:
    
       Stroke has a rating of 0.23
    
    CLIPS> (reset)
    CLIPS> (run)
    
    Welcome to the Headache Medical Diagnosis System
    
    Patient's name: Fred
    Patient's gender: (male female) male
    
    Does Fred have blurred vision? (yes no) no
    Does Fred have depression? (yes no) no
    Does Fred have trouble focusing? (yes no) no
    Does Fred have light sensitivity? (yes no) yes
    Does Fred have trouble sleeping? (yes no) no
    Does Fred feel numbness in body parts? (yes no) no
    Does Fred have dizziness? (yes no) no
    Does Fred have vomiting or an upset stomach? (yes no) no
    Does Fred feel fatigued? (yes no) no
    Does Fred have a fever? (yes no) no
    
    Your patient seems to have no serious symptoms.
    Recommendation is for rest until the headache goes away.
    
    CLIPS> (clear)
    CLIPS> (load headache.clp)
    +%%%%%!!!*+**+**+**+**+*+!**$$$$
    TRUE
    CLIPS> 

Readme from the original repository:

# Headache Diagnosis System
#### Assignment for Expert Systems in third year first trimester of Bac. of IT degree majoring in Artificial Intelligence (AI).

This is a medical diagnosis system programmed using the *CLIPS* language. This kind of system is also called an *Expert System*.
<br /><br />
This system is not for patient itself but for doctors themself to fill ask it asks questions like MRI and CT scans. Another reason is that this system will not provide the proper treatment even if the sickness is diagnosed.

There will be two files to be loaded into the CLIPS's dialog window.

Firstly, load q2.clp and only then load q2_1.clp.

1. This system will start by asking patient's information such as name and gender.
2. After that, it will ask 10 general questions such as fever and fatigueness.
3. It will then analyse the answers given to the 10 general questions and ask some more specific questions.
4. If all 10 general questions are answered no, the system will end and indicate no sickness for that patient.

#### Coded in one day by myself with medical resources from the internet.
