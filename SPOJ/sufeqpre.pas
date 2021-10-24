const   ginp='ss.inp';
        gout='ss.out';
        base=311;
        kk=round(1e9)+7;

var     gi,go:text;
        st,res,co:longint;
        p:array[0..1000001] of int64;

procedure create;
var     i:longint;
begin
        p[0]:=1;
        for i:=1 to 1000000 do p[i]:=(p[i-1]*base) mod kk;
end;

procedure process;
var     i,n:longint;
        h:array[0..1000001] of int64;
        s:ansistring;
begin
        readln(gi,s);
        n:=length(s);
        h[0]:=0;p[0]:=1;
        for i:=1 to n do
                h[i]:=(h[i-1]*base+ord(s[i])) mod kk;
        res:=0;
        for i:=1 to n-1 do
                if h[i]=(h[n]-h[n-i]*p[i]+kk*kk) mod kk then inc(res);
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,st);
        create;
        for co:=1 to st do
        begin
                process;
                writeln(go,'Case ',co,': ',res);
        end;
        close(gi);close(go);
end.
