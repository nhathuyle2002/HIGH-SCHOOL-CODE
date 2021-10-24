const   ginp='ss.inp';
        gout='ss.out';

var     n,m,r,vl:longint;
        res:int64;
        a:array[0..1010,0..1010] of longint;
        h,q,s:array[0..1010] of longint;

procedure enter;
var     i,j:longint;
begin
        readln(m,n);
        for i:=1 to m do
        begin
                for j:=1 to n do read(a[i,j]);
                readln;
        end;
end;

procedure push(k,i:longint);
begin
        while (r>0) and ((a[k,i]<>a[k,q[r]]) or (h[q[r]]>=h[i])) do dec(r);
        inc(r);q[r]:=i;
        if r=1 then s[r]:=(i-vl+1)*h[i]
        else s[r]:=s[r-1]+(i-q[r-1])*h[i];
        res:=res+s[r];
end;

procedure process;
var     i,j:longint;
begin
        for i:=1 to m do
        begin
                r:=0;
                for j:=1 to n do
                begin
                        if a[i,j]<>a[i,j-1] then vl:=j;
                        if a[i,j]=a[i-1,j] then inc(h[j]) else h[j]:=1;
                        push(i,j);
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
