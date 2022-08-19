basic_calculations.function = function(a,b){
a = as.integer(readline(prompt='In put a: '))
b = as.integer(readline(prompt='In put b: '))
tong = a + b 
hieu = a - b
tich = a * b
thuong = a/b

print(paste('Tong =', tong))
print(paste('Hieu =', hieu))
print(paste('Tich =', tich))
print(paste('Thuong =', thuong))

}

odd_even.function = function(x){
x = as.numericreadline(prompt='Input x: ')
if(x%%2==0){
    print(paste(x, 'is even number'))
}else{
    print(paste(x, 'is odd number'))
}
    }

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

electricity_bill.function = function(tien_dien,so_kw){
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
    
hotel_bill.function= function(ma_so,so_ngay){
vip1=1000000
vip2=900000
vip3=850000
standard1=700000
standard2=550000
    
ma_so=as.integer(readline(prompt='Nhap ma so (1/2/3/4/5): '))
so_ngay = as.integer(readline(prompt='Nhap so ngay: '))
    
don_gia_phong = switch(ma_so, vip1,vip2,vip3,standard1,standard2)
    
tien = 0 
if(so_ngay<3){
    tien=don_gia_phong*so_ngay
}else if(so_ngay<7){
    tien=don_gia_phong*so_ngay*0.9
}else{
    tien=don_gia_phong*so_ngay*0.8
}
         print(paste('Tien phai thanh toan: ',tien,'vnd'))
}
    
delivery_bill.function=function(chon_loai,sokm){
toi_thieu_2km_bike=10000
km_bike=3600

toi_thieu_2km_send = 15000
km_send = 4000
    
chon_loai = as.integer(readline(prompt='Nhap 1 chon GO-BIKE, 2 chon GO-SEND: '))

sokm = as.numeric(readline(prompt='So km:'))
    
tien_xe = 0 
if(chon_loai==1){
    if(sokm<2){
        tien_xe=toi_thieu_2km_bike
    }else{
        tien_xe=toi_thieu_2km_bike  + (sokm - 2)*km_bike
    }
}else if(chon_loai==2){
    if(sokm<2){
        tien_xe = toi_thieu_2km_send
    }else{
        tien_xe = toi_thieu_2km_send + (sokm - 2)*km_send
    }
}else {
    print('Chi co 2 loai la GO-BIKE va GO-SEND')
}

print(paste('Tien xe:', tien_xe, 'VND'))
chuoi_tien = paste(format(tien_xe, big.mark='.', decimal.mark=','),sep='')

print(paste('Tien xe: ', chuoi_tien,'VND'))
}

prime_check.function=function(n){
    # input
n = as.integer(prompt='Nhap n:')
flag = 0
# prime numbers are greater than 1
if(n>1){    
    # check for factors
    flag = 1
    for(i in 2:(n-1)) {
        if ((n %% i) == 0) {
            flag = 0
            break}
    }
} 
if(n == 2)    flag = 1
if(flag == 1) {
print(paste(n,"is a prime number"))
} else {
print(paste(n,"is not a prime number"))
}
}