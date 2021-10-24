const   ginp='number.inp';
        gout='number.out';

var     n,nn:longint;
        a:array[0..101] of longint;
        f,t:array[0..101,0..101] of longint;

procedure enter;
var     i,j:longint;
begin
        read(n);
        nn:=0;
        for i:=2 to n do
        begin
                for j:=2 to trunc(sqrt(i))+1 do
                        if i mod j=0 then break;
                if j=trunc(sqrt(i))+1 then
                begin
                        inc(nn);a[nn]:=i;
                end;
        end;
end;

procedure process;
var     i,tm,j,k:longint;
begin
        for i:=0 to n do f[0,i]:=1;
        for i:=1 to nn do
                for j:=0 to n do
                begin
                        f[i,j]:=f[i-1,j];
                        tm:=1;
                        for k:=1 to n do
                        begin
                                tm:=tm*a[i];
                                if j-tm<0 then break;
                                if f[i-1,j-tm]*tm>f[i,j] then
                                begin
                                        f[i,j]:=f[i-1,j-tm]*tm;
                                        t[i,j]:=tm;
                                end;
                        end;
                end;
        writeln(f[nn,n]);
        i:=nn;j:=n;
        while (i>0) and (j>0) do
        begin
                if t[i,j]>0 then write(t[i,j],' ');
                j:=j-t[i,j];
                dec(i);
        end;
        for i:=j downto 1 do write(1,' ');
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
