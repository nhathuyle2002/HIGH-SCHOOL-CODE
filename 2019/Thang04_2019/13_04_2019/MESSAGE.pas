const   fi='MESSAGE.INP';
        fo='MESSAGE.OUT';
type    mang=array[0..1000] of int64;
var     s,a:string;
        n,m,kq:int64;
        f1,f2:mang;
        f,g:text;
        d:array[0..100,'a'..'z'] of longint;
        ff:array[0..100,0..100] of int64;
function        tih(b:string):longint;
begin
        while length(b)>length(a) do delete(b,1,1);
        while length(b)>0 do
        begin
                if b=copY(a,1,length(b)) then exit(length(b));
                delete(b,1,1);
        end;
        exit(0);
end;
procedure       tinh(xx:string;var f:mang);
var     i,j,kk:longint;
        tmp:string;
        x:char;
begin
        a:=xx;
        tmp:='';
        for x:='a' to 'z' do
                d[0,x]:=0;
        d[0,a[1]]:=1;
        kk:=length(a);
        for i:=1 to kk do
        begin
                tmp:=tmp+a[i];
                for x:='a' to 'z' do
                begin
                        d[i,x]:=tih(tmp+x);
                        write(g, d[i,x],' ');
                end;
                writeln(g);
        end;
        for i:=0 to n do
        begin
                f[i]:=0;
                for j:=0 to kk do
                        ff[i,j]:=0;
        end;
        f[0]:=1;
        ff[0,kk]:=1;
        for i:=0 to n-1 do
        for j:=0 to kk do
        if ff[i,j]>0 then
                for x:='a' to 'z' do
                if d[j,x]<kk then
                        begin
                                ff[i+1,d[j,x]]:=(ff[i+1,d[j,x]]+ff[i,j]) mod m;
                                f[i+1]:=(f[i+1]+ff[i,j]) mod m;
                        end;
end;
function        nhan(a,b:int64):int64;
var     c:array[1..50] of int64;
        i,j,k:longint;
        tmp:int64;
begin
        for i:=1 to 50 do
                c[i]:=0;
        j:=0;
        while a>0 do
        begin
                tmp:=(a mod 10) *b;
                inc(j);
                k:=j;
                while tmp>0 do
                begin
                        inc(c[k],tmp mod 10);
                        tmp:=tmp div 10;
                        inc(k);
                end;
                a:=a div 10;
        end;
        tmp:=0;
        for i:=50 downto 1 do
                tmp:=(tmp*10+c[i]) mod m;
        exit(tmp);
end;
procedure       xuli;
var     i,j:longint;
        tmp:string;
begin
        f2[0]:=1;
        for i:=1 to n do
                f2[i]:=(f2[i-1]*26) mod m;
        tmp:=s;
        for i:=1 to length(s) do
                tmp[i]:=s[length(s)-i+1];
        tinh(tmp,f1);
        kq:=0;
        for i:=0 to n do
        if i+length(s)<=n then
                //kq:=(kq+f1[i]*f2[n-i-length(s)]) mod m;
                  kq:=(kq+nhan(f1[i],f2[n-i-length(s)])) mod m;

end;
procedure       nhapxuat;
var
        t:longint;
begin
        assign(f,fi); reset(f);
        assign(g,fo); rewritE(g);
        readln(f,t);
        while t>0 do
        begin
                dec(t);
                readln(f,n,m);
                readln(f,s);
                xuli;
                writeln(g,kq);
        end;
        close(f); closE(g);
end;
begin
        nhapxuat;
end.
