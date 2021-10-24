const   ginp='delnum.inp';
        gout='delnum.out';

var     gi,go:text;
        n,r:longint;
        a,q:array[0..100010] of longint;
        d:array[0..100010] of boolean;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n);
        for i:=1 to n do read(gi,a[i]);
end;

procedure push(i:longint);
begin
        while (r>0) and (a[i]>a[q[r]]) do
        begin
                if r<>1 then d[q[r]]:=false;
                dec(r);
        end;
        if a[i]=a[q[r]] then r:=0;
        inc(r);q[r]:=i;
end;

procedure output;
var     i,ans:longint;
begin
        fillchar(d,sizeof(d),true);
        a[0]:=-maxlongint;r:=0;
        for i:=1 to n do push(i);
        ans:=0;
        for i:=1 to n do
                if d[i] then inc(ans);
        write(go,ans);
        close(gi);close(go);
end;

begin
        input;
        output;
end.
