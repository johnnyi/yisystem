#!/bin/bash
#Author : Yi Xiaohui
#MSN    : yxh_benet@hotmail.com
#QQ     : 398774310

#######################################################################################
#######################################################################################
#dispose keys
yixh01='ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAoSyf3tM8m2wYyKAbkwr10sz+GSl9dTHzWcs+tacshZZuARwh49+jfG+a4HefCSr1f+3Mwg8oP0WwBInB7uODHM1vo0xpBSVxA7pB+QR6m1PhU4NU7VdEeOZZAtV6tJzqe1gXkFiND/bIk5EUyQwHAC7YabKvJ52qT7cxpZ7xBS60zTDAUPXWZ4VnGraHKXk3pt38V1GVkmguB06dSXqY566uZzE5ATwoDKCmxs1QOs0peSP3P5ulLA4H/gnJaK1yFdBvgenXF7xktfraAN6R7i147WCTnMvwXd13ANokf/Wsonq0xUs5gDqMYKo+d4Y4aBjyilAKUh89RxTKKMDtAw== yixh01@test01.kj.quitein.com'
yixh02='ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA+FpWaWljR8f0g3mkVAAu/mE9WhKefe36bvVe/FGMaFS1G4As4Uo3EFrnfJxFSKL53LuG+0y4bGIWO1RwBkY+ybDyaGraLHsClK4pB1GcSNCBzHbV9VzLAqStk3mCEYroYDWioDTttIVr6wwlsWt+FF67sbhSVLvIKA19CZpLBYaEe3Zm2OBoy3TkEaCik1BTFGkCQ/UhICbVQd86JsIkdEQBtuLjMXcb9cH0AYACphZN35Wli88IGW2I2kB2obQig9nf66S9HrUg40He/dJ0jh5P13hVN0w+thQrR08YndkKG6/fJO5QhYynj+lWLNfU4jECPPlbIWw4vY56Rx50qw== yixh02@web03.kj.quitein.com'

for i in yixh
do
    [ -d /home/$i/.ssh ] || mkdir /home/$i/.ssh
    echo $yixh01  >> /home/$i/.ssh/authorized_keys
    echo $yixh02  >> /home/$i/.ssh/authorized_keys
    chown -R `id -u $i`.`id -g $i` /home/$i/.ssh
    chmod 700 /home/$i/.ssh
    chmod 644 /home/$i/.ssh/authorized_keys

done

