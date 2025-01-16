{

  description = "A Flake for PostgreSQL";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs, ... }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forEachSupportedSystem = f: nixpkgs.lib.genAttrs supportedSystems (system: f {
        pkgs = import nixpkgs { inherit system; };
      });
    in
    {
      devShells = forEachSupportedSystem ({ pkgs }: {
        default = pkgs.mkShell
          {
            buildInputs = with pkgs; [
              postgresql_17
            ];

            shellHook = ''
              export PG=$PWD/.dev_postgres/
              export PGDATA=$PG/data
              export PGPORT=5432
              export PGHOST=localhost
              export PGUSER=$USER
              export PGPASSWORD=postgres
              # export PGDATABASE=example
              # export DB_URL=postgres://$PGUSER:$PGPASSWORD@$PGHOST:$PGPORT/$PGDATABASE

              alias pg_start="pg_ctl -D $PGDATA -l $PG/postgres.log start"
              alias pg_stop="pg_ctl -D $PGDATA stop"
              pg_setup() {
                pg_stop;
                rm -rf $PG;
                initdb -D $PGDATA &&
                echo "unix_socket_directories = '$PGDATA'" >> $PGDATA/postgresql.conf &&
                pg_start &&
                createdb
              }
            '';
          };
      });
    };

}
