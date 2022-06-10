#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='logo-ls -l'
alias la='logo-ls -la'
alias b='upower -i $(upower -e | grep '/battery') | grep --color=never -E "state|to\ full|to\ empty|percentage"'
alias wifi='sudo iw dev wlan0 connect -w $1'
alias pw="pwgen -sync -1 64 | tr '\n' ' ' | sed 's+ ++g' | xclip -i -selection clipboard"
PS1='[\u@\h \W]\$ '

export PATH=$PATH:~/.local/bin
export PATH=$PATH:~/go/bin
export PATH=$PATH:/home/jd/.local/share/gem/ruby/3.0.0/bin
export PATH="/usr/lib/jvm/java-18-openjdk/bin:$PATH"
export JAVA_HOME="/usr/lib/jvm/java-18-openjdk"
export HADOOP_HOME="/usr/lib/hadoop"
export HADOOP_YARN_HOME=$HADOOP_HOME
export PATH=$PATH:/usr/lib/hadoop/sbin

## Hadoop mess
export HADOOP_INSTALL=$HADOOP_HOME
export HADOOP_MAPRED_HOME=$HADOOP_HOME
export HADOOP_COMMON_HOME=$HADOOP_HOME
export HADOOP_HDFS_HOME=$HADOOP_HOME
export HADOOP_YARN_HOME=$HADOOP_HOME
export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
export PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin
export HADOOP_OPTS="-Djava.library.path=$HADOOP_HOME/lib/native"
