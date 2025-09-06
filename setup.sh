#!/bin/zsh

# Set up directories and PATH
export HOME_DIR=$HOME
mkdir -p $HOME_DIR/pg $HOME_DIR/pgdata $HOME_DIR/bison $HOME_DIR/m4

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

# Download and install PostgreSQL
cd $HOME_DIR
wget https://ftp.postgresql.org/pub/source/v17.0/postgresql-17.0.tar.gz
tar xvzf postgresql-17.0.tar.gz
cd postgresql-17.0
./configure --prefix=$HOME_DIR/pg --without-icu
make && make install
export PATH=$HOME_DIR/pg/bin:$PATH

# Add PATH updates to ~/.zshrc for persistence
echo 'export PATH=$HOME/m4/bin:$HOME/bison/bin:$HOME/pg/bin:$PATH' >> ~/.zshrc

# Initialize and start PostgreSQL
initdb -D $HOME_DIR/pgdata
pg_ctl -D $HOME_DIR/pgdata -l logfile start

# Create a database and connect
createdb mydb
psql mydb
