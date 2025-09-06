#!/bin/zsh

# Set up directories and PATH
export HOME_DIR=$HOME
mkdir -p $HOME_DIR/pg $HOME_DIR/pgdata $HOME_DIR/bison $HOME_DIR/m4 $HOME_DIR/flex

# Download and install M4
cd $HOME_DIR
wget http://ftp.gnu.org/gnu/m4/m4-1.4.19.tar.gz
tar xvzf m4-1.4.19.tar.gz
cd m4-1.4.19
./configure --prefix=$HOME_DIR/m4
make && make install
export PATH=$HOME_DIR/m4/bin:$PATH

# Download and install Bison
cd $HOME_DIR
wget http://ftp.gnu.org/gnu/bison/bison-3.8.2.tar.gz
tar xvzf bison-3.8.2.tar.gz
cd bison-3.8.2
./configure --prefix=$HOME_DIR/bison
make && make install
export PATH=$HOME_DIR/bison/bin:$PATH

# Download and install Flex
cd $HOME_DIR
wget https://github.com/westes/flex/releases/download/v2.6.4/flex-2.6.4.tar.gz
tar xvzf flex-2.6.4.tar.gz
cd flex-2.6.4
./configure --prefix=$HOME_DIR/flex
make && make install
export PATH=$HOME_DIR/flex/bin:$PATH

# Download and install PostgreSQL
cd $HOME_DIR
wget https://ftp.postgresql.org/pub/source/v17.0/postgresql-17.0.tar.gz
tar xvzf postgresql-17.0.tar.gz
cd postgresql-17.0
./configure --prefix=$HOME_DIR/pg --without-icu --without-readline
make && make install
export PATH=$HOME_DIR/pg/bin:$PATH

# Add PATH updates to ~/.zshrc for persistence
echo 'export PATH=$HOME/m4/bin:$HOME/bison/bin:$HOME/flex/bin:$HOME/pg/bin:$PATH' >> ~/.zshrc

# Initialize and start PostgreSQL
initdb -D $HOME_DIR/pgdata
pg_ctl -D $HOME_DIR/pgdata -l logfile start

# Create a database and connect
createdb mydb
psql mydb
