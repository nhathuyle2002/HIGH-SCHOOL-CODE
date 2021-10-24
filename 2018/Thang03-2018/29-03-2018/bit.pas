const   ginp='bit.inp';
        gout='bit.out';

var     gi,go:text;
        n,l,r,ans:longint;
        a:array[0..4001] of longint;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,l,r);
        for i:=1 to n do read(gi,a[i]);
end;

function tinh(i1,i2,i3,i4:longint):longint;
begin
        tinh:=((a[i1] and a[i2]) or a[i3]) xor a[i4];
end;

procedure process;
var     i1,i2,i3,i4,tmp:longint;
begin
        for i1:=1 to n do
                for i2:=i1+1 to n do
                        for i3:=i2+1 to n do
                                for i4:=i3+1 to n do
                                begin
                                        tmp:=tinh(i1,i2,i3,i4);
                                        if (tmp>=l) and (tmp<=r) then inc(ans);
                                end;
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








