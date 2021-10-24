const   fi='LRGAME.inp';
        fo='LRGAME.out';
var     a,b,NA:string;
        n: longint;
        dd:array[0..51,0..51,0..1] of byte;
        f :array[0..51,0..51,0..1] of string;
        //dem:array['0'..'9'] of longint;

function cal( ii ,jj ,over: longint): string;
var     i,ov:longint;
        tmp:string;
begin
        if ii=0 then exit('');
        if dd[ii,jj,over]=1 then exit(f[ii,jj,over]);

        cal:=NA;
        for i:=1 to ii do if (a[i]>=b[jj]) or (over=1) then
        begin
                if a[i]=b[jj] then ov:=over else ov:=1;
                tmp:=cal(i-1,jj+1,ov);
                if tmp <> NA then
                begin
                        tmp:= a[i] + tmp + copy(a,i+1,ii-i);
                        if ((over=1) or (tmp>=copy(b,jj,ii))) and ((cal=NA) or (cal>tmp)) then cal:=tmp;
                end;
        end;
        dd[ii,jj,over]:=1;
         f[ii,jj,over]:=cal
end;

procedure main;
var     i:longint;
        kq:string;
begin
        NA:='-1';
        n:= length(a);
        kq:= cal( n , 1 , 0);
        write(kq);
end;

begin
        assign(input,fi);  assign(output,fo);
        reset(input);      rewrite(output);
        readln(a);
        read(b);
        main;
        close(input);      close(output);
end.