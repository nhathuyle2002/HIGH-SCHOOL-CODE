const   ginp='catbanh.inp';
        gout='catbanh.out';

var     n,k:longint;
        res:int64;
        a:array[0..510,-510..510] of longint;
        s,c:array[0..510,-510..510] of int64;

procedure enter;
var     i,j:longint;
begin
        readln(n,k);
        inc(k);
        for i:=1 to n do
        begin
                for j:=1 to n do
                begin
                        read(a[i,j]);
                        s[i,i-j]:=s[i-1,i-j]+a[i,j];
                        c[i,j]:=c[i-1,j]+a[i,j];
                end;
                readln;
        end;
end;

procedure process;
var     i,j:longint;
        tmp:int64;
begin
        res:=0;
        for i:=k to n do
        begin
                tmp:=0;
                for j:=1 to k-1 do tmp:=tmp+s[i,i-j];
                for j:=k to n do
                begin
                        tmp:=tmp+s[i,i-j]-s[i-k,i-j]-c[i,j-k]+c[i-k,j-k];
                        if tmp>res then res:=tmp;
                end;
        end;
        write(res);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
