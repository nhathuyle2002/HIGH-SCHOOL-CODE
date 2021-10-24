const   ginp='plant.inp';
        gout='plant.out';
        maxg=1000010;

var     n:longint;
        f,s:array[0..maxg] of longint;

function quece(i:longint):longint;
begin
        if i<1 then exit(0);
        quece:=f[i]+quece(i-i and (-i));
end;

procedure update(i,x:longint);
begin
        if i>maxg then exit;
        f[i]:=f[i]+x;
        update(i+i and (-i),x);
end;

procedure process;
var     i,l,r,sl,sr:longint;
begin
        readln(n);
        for i:=1 to n do
        begin
                readln(l,r);
                sl:=quece(l);sr:=quece(r);
                writeln(sl-s[l]+sr-s[r]);
                s[l]:=sl;s[r]:=sr;
                update(l+1,1);
                update(r,-1);
        end;
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        process;
        close(input);close(output);
end.
