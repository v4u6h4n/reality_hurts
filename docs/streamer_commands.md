# Automation

<ins>Format:</ins>

```
<command>
```

<ins>Command:</ins>

```
-au     --automation
```

# Censor


# Stream

<ins>Format:</ins>

```
<command> <action> <platform> <account> <action> [category] [activity]
```

<ins>Command:</ins>

```
-str    --stream
```

<ins>Action:</ins>

```
i       info
q       query
r       refresh

```

<ins>Platform:</ins>

```
all
twitch
```

<ins>Account:</ins>

```
all
<account name>
```

<ins>Restriction:</ins>

```
r       restricted
ur      unrestricted
```

<ins>Stream Type:</ins>

```
a       active
n       normal
u       passive
```

<ins>Category:</ins>

```
c       chatting
p       passive
sl      sleeping
```

<ins>Activity:</ins>

```
-a     --activity

a       admin
c       chores
ch      chilling
co      coding
c_b     cooking_breakfast
c_l     cooking_lunch
c_d     cooking_dinner
cr      crafts
d       dancing
e_b     eating_breakfast
e_l     eating_lunch
e_d     eating_dinner
f       fitness
m       morning
p       painting
r       relationship
se      sewing
s       socialising
t_i     therapy_informal
w       waking_up
```

# Permission

<ins>Format:</ins>

```
<command> <subcommand> <action> <role> [subcommand] [action] [role]
```

<ins>Command:</ins>

```
-pe     --permission
```

<ins>Subcommand:</ins>

```
ch      channel
sc      scene
```

<ins>Action:</ins>

```
s       select
t       toggle
```

<ins>Role:</ins>

```
o       owner
l       leaseholder
r       roommate
h       housemate
c       couchsurfer
e       everyone
```

# Playback

<ins>Format:</ins>

```
<command> <attribute> <action>
```

<ins>Command:</ins>

```
-pl    --playback
```

<ins>Attribute:</ins>

```
pl      playback
se      seek
sk      skip
v       volume
```

<ins>Action:</ins>

```
m       monitor
t       toggle

b       back
f       forward

n       next
p       previous

d       down
u       up
```

# Restriction

<ins>Format:</ins>

```
<command> <profile> <camera>
```

<ins>Command:</ins>

```
-r     --restriction
```

<ins>Profile:</ins>

```
r       restricted
u       unrestricted
```

<ins>Scene:</ins>

```
a       all
ba      bathroom
be      bed
d       desk
s       studio
```

# Scene

<ins>Format:</ins>

```
<command> [name] [scene] [name] [scene]
```

<ins>Command:</ins>

```
!s     !scene
```

<ins>Name:</ins>

```
a       anja
v       vaughan
```

<ins>Scene:</ins>

```
ba      bathroom
be      bed
d       desk
k       kitchen
s       studio
```