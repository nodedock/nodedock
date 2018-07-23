FROM adminer:4.3.0

# Version 4.3.1 contains PostgreSQL login errors. See docs.
# See https://sourceforge.net/p/adminer/bugs-and-features/548/

# Add volume for sessions to allow session persistence
VOLUME /sessions

USER adminer

# We expose Adminer on port 8080 (Adminer's default)
EXPOSE 8080
