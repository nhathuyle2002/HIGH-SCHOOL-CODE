const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        n,k,l,maxn:longint;
        a:array[0..51] of longint;
        d:array[-10..1000001] of boolean;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,k,l,n);
        maxn:=0;
        for i:=1 to n do
        begin
                read(gi,a[i]);
                if a[i]>maxn then maxn:=a[i];
        end;
end;

procedure process;
var     i:longint;
begin
        fillchar(d,sizeof(d),false);
        for i:=1 to maxn do
        begin
                if (d[i-k]=false) and (i-k>=0) then d[i]:=true;
                if (d[i-l]=false) and (i-l>=0) then d[i]:=true;
                if (d[i-1]=false) then d[i]:=true;
        end;
end;

procedure output;
var     i:longint;
begin
        for i:=1 to n do
                if d[a[i]] then write(go,'A') else write(go,'B');
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.
