const   ginp='matrix.inp';
        gout='matrix.out';

var     n,k,vi,vj:longint;
        a:ansistring;
        res:int64;

function get(i:longint):int64;
begin
        get:=int64(i)*(i+1) div 2;
end;

procedure ch(x:char);
begin
        if x='U' then dec(vi) else
        if x='D' then inc(vi) else
        if x='L' then dec(vj) else
        if x='R' then inc(vj);
end;

procedure process;
var     i:longint;
        tmp:int64;
begin
        readln(n,k);
        read(a);
        vi:=1;vj:=1;
        for i:=1 to k do
        begin
                ch(a[i]);
                if vi+vj<=n+1 then
                begin
                        tmp:=get(vi+vj-2);
                        if (vi+vj) and 1=0 then tmp:=tmp+vj
                        else tmp:=tmp+vi;
                end else
                begin
                        tmp:=get(n)+get(n-1)-get(2*n-vi-vj+1);
                        if (vi+vj) and 1=0 then tmp:=tmp+n-vi+1
                        else tmp:=tmp+n-vj+1;
                end;
                res:=res+tmp;
        end;
        write(res+1);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        process;
        close(input);close(output);
end.
