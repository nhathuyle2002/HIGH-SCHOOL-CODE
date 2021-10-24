const   ginp='special.inp';
        gout='special.out';

var     gi,go:text;
        n:longint;
        ans:int64;
        a:array[0..1001,0..1001] of longint;
        cc,cp:array[-1001..2001] of longint;

procedure input;
var     i,j:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n);
        for i:=1 to n do
        begin
                for j:=1 to n do read(gi,a[i,j]);
                readln(gi);
        end;
end;

function max(x,y:longint):longint;
begin
        if x>y then exit(x) else exit(y);
end;

function min(x,y:longint):longint;
begin
        if x<y then exit(x) else exit(y);
end;

procedure process;
var     i,j:longint;
begin
        for i:=1 to n do
        begin
                cc[1-i]:=a[1,i];
                cc[i-1]:=a[i,1];
        end;
        for i:=2 to n do
                for j:=2 to n do
                        cc[i-j]:=max(cc[i-j],a[i,j]);
        for i:=1 to n do
        begin
                cp[1+i]:=a[1,i];
                cp[i+n]:=a[i,n];
        end;
        for i:=2 to n do
                for j:=1 to n-1 do
                        cp[i+j]:=min(cp[i+j],a[i,j]);
        for i:=1 to n do
                for j:=1 to n do
                        if (cc[i-j]=a[i,j]) and (cp[i+j]=a[i,j]) then ans:=ans+a[i,j];
end;

procedure output;
begin
        write(go,ans);
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.













