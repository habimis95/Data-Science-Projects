sum_even.function = function(start,end){
    sum_even = 0
    for(i in start:end){
        if(i%%2==0){
            sum_even = sum_even + i
        }
    }
    return(sum_even)
}

drink.function = function(price, type='Tea'){
    print(paste('With', price, ', you can drink', type))
}

tien_dien.function = function(tien_dien,so_kw){
muc1=1678
muc2=1734
muc3=2014
muc4=2536
muc5=2834
muc6=2927

bac50=50
bac100=100

tien_dien=0

so_kw=as.integer(readline(prompt='So kw tieu thu: '))

if(so_kw<=50){
    tien_dien=so_kw*muc1
}   else if(so_kw<=100){
    tien_dien=bac50*muc1+(so_kw-bac50)*muc2
}   else if(so_kw<=200){
    tien_dien=bac50*muc1+bac50*muc2+(so_kw - bac100)*muc3
}   else if(so_kw<=300){
    tien_dien=bac50*muc1+bac50*muc2+bac100*muc3+(so_kw-bac50-bac50=bac100)*muc4
}   else if(so_kw<=400){
    tien_dien=bac50*muc1+bac50*muc2+bac100*muc3+bac100*muc4+(so_kw - bac50 - bac50 - bac100 - bac100)*muc5
}   else{ 
    tien_dien=bac50*muc1+bac50*muc2+bac100*muc3+bac100*muc4+bac100*muc5(so_kw - bac50 - bac50 - bac100 - bac100 - bac100)*muc6
}
    }