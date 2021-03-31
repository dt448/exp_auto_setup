#!/bin/bash

read -p "EXP NO: " EXP_NAME
read -p "Descriptive Exp Name: " DES_EXP_NAME
read -p "Describe experiment in one line: " EXP_DESCRIPTION

#sanitizing input
SAN_DES_EXP_NAME=${DES_EXP_NAME// /_}
SAN_DES_EXP_NAME=${SAN_DES_EXP_NAME/[^a-zA-Z0-9_]/}

DATE_STAMP=$(date "+%Y%m%d")
EXP_UID="${DATE_STAMP}_EXP$EXP_NAME"
EXP_DIR="${EXP_UID}_${SAN_DES_EXP_NAME}"

# echo $EXP_DIR
mkdir $EXP_DIR

# creating log file
EXP_LOG_NAME="0_${EXP_UID}.log"
echo $EXP_DIR/$EXP_LOG_NAME
EXP_LOG_DIR=$EXP_DIR/$EXP_LOG_NAME
touch $EXP_DIR/$EXP_LOG_NAME


echo -e "EXP UID:\t\t $EXP_UID">> $EXP_LOG_DIR
echo -e "EXP NAME:\t\t $DES_EXP_NAME" >> $EXP_LOG_DIR
echo -e "EXP DESP:\t\t $EXP_DESCRIPTION \n" >> $EXP_LOG_DIR
echo -e "LOG $(date "+%Y/%m/%d %H:%M")- Created Exp Dirs" >> $EXP_LOG_DIR

mkdir $EXP_DIR/1_exp_design  $EXP_DIR/2_exp_outputs $EXP_DIR/3_exp_analysis

DESIGN_DIR=$EXP_DIR/1_exp_design
MAIN_SUB_DESIGN="$DESIGN_DIR/${EXP_UID}_MAIN.Rmd"
touch $MAIN_SUB_DESIGN

echo -e "EXP UID:\t\t ${EXP_UID}MAIN">> $MAIN_SUB_DESIGN
echo -e "EXP NAME:\t\t $DES_EXP_NAME" >> $MAIN_SUB_DESIGN
echo -e "EXP DESP:\t\t $EXP_DESCRIPTION" >> $MAIN_SUB_DESIGN
echo -e "SUB DESP:\t\t [Write in detail what this SUB EXP is doing] \n" >> $MAIN_SUB_DESIGN
echo -e "[WRITE THE DESCRIPTION OF THE EXPERIMENT IN DETAIL AND ALSO STATE THE DESIGN ]" >> $MAIN_SUB_DESIGN
echo -e "\`\`\`{r warning=FALSE} \n #Preample \n \n #code here \n \n MAIN_FIXED_CONFIG = \n \n #Design Variables \n design_var_1 = \n \n\`\`\` \n" >>$MAIN_SUB_DESIGN
echo -e " #Save config once running \n\`\`\`{r warning=FALSE} \n save.RDS(MAIN_FIXED_CONFIG,\"dir_here_/$EXP_DIR/2_exp_outputs/MAIN_FIXED_CONFIG.RDS\") \n\`\`\` \n" >>$MAIN_SUB_DESIGN
echo -e "# SCRIPT : ${EXP_UID}MAIN_SC1" >>$MAIN_SUB_DESIGN
echo -e "\`\`\`{r warning=FALSE} \n SAVEDIRECTORY = \n set.seed() \n \n\`\`\`" >>$MAIN_SUB_DESIGN
