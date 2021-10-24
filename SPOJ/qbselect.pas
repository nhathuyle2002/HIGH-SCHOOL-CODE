const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        n,ans:longint;
        a:array[0..10001,0..4] of longint;
        f:array[0..10001,0..8] of longint;
        c:array[1..8,-1..8] of longint;

procedure input;
var     i,j,cou,tm:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n);
        cou:=0;tm:=-30010;
        for i:=1 to 4 do
        begin
                for j:=1 to n do
                begin
                        read(gi,a[j,i]);
                        if a[j,i]<0 then
                        begin
                                inc(cou);
                                if tm<a[j,i] then tm:=a[j,i];
                        end;
                end;
                readln(gi);
        end;
        if cou=4*n then ans:=tm;
end;

function ccl(i,j:longint):longint;
var     k,tm:longint;
begin
        ccl:=a[i,c[j,-1]]+a[i,c[j,0]];
        dec(i);tm:=0;
        for k:=1 to 8 do
                 if tm<f[i,c[j,k]] then tm:=f[i,c[j,k]];
        ccl:=ccl+tm;
end;

procedure process;
var     i,j:longint;
begin
        c[1,-1]:=0;c[1,0]:=1;c[1,1]:=2;c[1,2]:=3;c[1,3]:=4;c[1,4]:=7;c[1,5]:=8;
        c[2,-1]:=0;c[2,0]:=2;c[2,1]:=1;c[2,2]:=3;c[2,3]:=4;c[2,4]:=5;c[2,5]:=6;c[2,6]:=8;
        c[3,-1]:=0;c[3,0]:=3;c[3,1]:=1;c[3,2]:=2;c[3,3]:=4;c[3,4]:=6;c[3,5]:=7;c[3,6]:=8;
        c[4,-1]:=0;c[4,0]:=4;c[4,1]:=1;c[4,2]:=2;c[4,3]:=3;c[4,4]:=5;c[4,5]:=8;
        c[5,-1]:=1;c[5,0]:=3;c[5,1]:=2;c[5,2]:=4;c[5,3]:=7;c[5,4]:=8;
        c[6,-1]:=1;c[6,0]:=4;c[6,1]:=2;c[6,2]:=3;c[6,3]:=8;
        c[7,-1]:=2;c[7,0]:=4;c[7,1]:=1;c[7,2]:=3;c[7,3]:=5;c[7,4]:=8;
        c[8,1]:=1;c[8,2]:=2;c[8,3]:=3;c[8,4]:=4;c[8,5]:=5;c[8,6]:=6;c[8,7]:=7;c[8,8]:=8;
        for i:=1 to n do
                for j:=1 to 8 do
                        f[i,j]:=ccl(i,j);
end;

procedure output;
var     i:longint;
begin
        if ans=0 then
        for i:=1 to 8 do
                if f[n,i]>ans then ans:=f[n,i];
        write(go,ans);
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.
