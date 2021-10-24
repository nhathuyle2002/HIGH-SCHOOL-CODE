const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        n,st,q:longint;
        d:array[0..10001] of int64;

procedure input;
var     i,l,r,val:longint;
begin
        fillchar(d,sizeof(d),0);
        readln(gi,n,q);
        for i:=1 to q do
        begin
                readln(gi,l,r,val);
                d[l]:=d[l]+val;
                d[r+1]:=d[r+1]-val;
        end;
end;

procedure process;
var     i,vt:longint;
begin
        for i:=1 to n-1 do
                d[i]:=d[i-1]+d[i];
        readln(gi,q);
        for i:=1 to q do
        begin
                readln(gi,vt);
                writeln(go,d[vt]);
        end;
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,st);
        while st>0 do
        begin
                input;
                process;
                dec(st);
        end;
        close(gi);close(go);
end.
