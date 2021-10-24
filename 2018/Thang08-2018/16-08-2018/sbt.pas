const   ginp='sbt.inp';
        gout='sbt.out';

var     n,m:longint;
        a,b:string[20];
        sa,sb,s2a,s2b:array[0..19] of longint;
        f:array[0..19,0..19*9,0..19*81] of int64;
        res,l,r:int64;
        d:array[0..19*9,0..19*81] of boolean;

function ucln(x,y:longint):longint;
begin
        if y=0 then exit(x);
        ucln:=ucln(y,x mod y);
end;

procedure enter;
var     i:longint;
        c,d:string[20];
begin
        read(l,r);
        inc(r);
        str(l,c);str(r,d);
        for i:=length(c) downto 1 do a:=a+c[i];
        m:=length(a);
        for i:=length(d) downto 1 do b:=b+d[i];
        n:=length(b);
        while length(a)<n do a:=a+'0';
        for i:=1 to n do
        begin
                sa[i]:=sa[i-1]+ord(a[i])-48;
                sb[i]:=sb[i-1]+ord(b[i])-48;
                s2a[i]:=s2a[i-1]+sqr(ord(a[i])-48);
                s2b[i]:=s2b[i-1]+sqr(ord(b[i])-48);
        end;
        a:=a+'0';
        b:=b+'0';
end;

procedure process;
var     i,s1,s2,ii,sa1,sa2,sb1,sb2:longint;
        tm:int64;
begin
        for s1:=0 to n*9 do
                for s2:=0 to n*81 do
                        if ucln(s1,s2)=1 then d[s1,s2]:=true else d[s1,s2]:=false;
        res:=0;
        f[0,0,0]:=1;tm:=0;
        for i:=1 to n do
        for s1:=0 to 9*i do
        for s2:=0 to 81*i do
        begin
                for ii:=0 to 9 do
                begin
                        sa1:=s1+sa[n]-sa[i];sa2:=s2+s2a[n]-s2a[i];
                        if (ii=ord(a[i])-48) and (d[sa1,sa2]) then res:=res-f[i,s1,s2];
                        sb1:=s1+sb[n]-sb[i];sb2:=s2+s2b[n]-s2b[i];
                        if (ii=ord(b[i])-48) and (d[sb1,sb2]) then res:=res+f[i,s1,s2];
                        if (s1-ii>=0) and (s2-ii*ii>=0) then f[i,s1,s2]:=f[i,s1,s2]+f[i-1,s1-ii,s2-ii*ii];
                        if ii=0 then tm:=f[i,s1,s2];
                end;
                if (i<m) and (d[s1,s2]) then res:=res-f[i,s1,s2]+tm;
                if (i=m) and (d[s1,s2]) then res:=res+tm;
                if (i<n) and (d[s1,s2]) then res:=res+f[i,s1,s2]-tm;
                if (i=n) and (d[s1,s2]) then res:=res-tm;
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
