# roboshop-shell
Roboshop Woo Commerce Project

### SED Command Options
---
delete some lines
    - based on line numbers
    |   sed -i -e '1d' passwd
    - string based delete
    |   sed -i -e '/nologin/ d' passwd

add some lines
    - sed -i -e '1 a Hello' -e '/mongod/ a Hello World' passwd
modify(change) some lines
|   - sed -i -e '2 c Hello Universe' -e '/centos/ c Hello Galaxy' passwd

delete some words
    sed -i -e 's|Hello||g' passwd
modify(substitute) some words
    sed -i -e 's|bin|BIN|g' passwd
    sed -i -e '10s|bin|BIN|g' passwd
Instead of | we can use /, ?, :, ;, #, @

---
