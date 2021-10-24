const   ginp='area0.inp';
        gout='area0.out';

var     m,n:longint;
        a,f:array[0..510,0..510] of int64;

procedure enter;
var     i,j:longint;
begin
        readln(m,n);
        for i:=1 to m do
        begin
                for j:=1 to n do
                begin
                        read(a[i,j]);
                        a[i,j]:=a[i,j-1]+a[i,j];
                end;
                readln;
        end;
end;

function max(x,y:int64):int64;
begin
        if x>y then exit(x) else exit(y);
end;

procedure process;
var     j1,j2,i,i0:longint;
begin
        for j1:=1 to n do
        for j2:=j1 to n do
        begin
                i:=m+1;
                repeat
                        i0:=i;dec(i);
                        while (i>0) and (a[i,j2]=a[i,j1-1]) do
                        begin
                                f[i,j1]:=max(f[i,j1],int64(i0-i)*(j2-j1+1));
                                dec(i);
                        end;
                until i=0;
        end;
        for i:=1 to m do
        begin
                for j1:=1 to n do write(f[i,j1],' ');
                writeln;
        end;
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
