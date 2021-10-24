const   ginp='project.inp';
        gout='project.out';
        oo=high(qword);

var     h,s,d:qword;
        n,r,rr:longint;
        f:array[0..1000010] of qword;
        a,q,t,b:array[0..1000010] of longint;

procedure enter;
var     i:longint;
begin
        readln(n);
        readln(h,s,d);
        for i:=1 to n do read(a[i]);
end;

procedure process;
var     i,j:longint;
        ss:qword;
begin
        r:=1;q[1]:=0;a[0]:=0;
        for i:=1 to n do
        begin
                f[i]:=oo;
                while (r>0) and (a[i]>=a[q[r]]) do
                begin
                        ss:=f[q[r]]+int64(i-q[r])*a[q[r]]*s+int64(a[i]-a[q[r]])*(h+s);
                        if f[i]>ss then
                        begin
                                f[i]:=ss;
                                t[i]:=q[r];
                        end;
                        dec(r);
                end;
                if r>0 then
                begin
                        ss:=f[q[r]]+int64(i-q[r])*a[i]*s+int64(a[q[r]]-a[i])*d;
                        if f[i]>ss then
                        begin
                                f[i]:=ss;
                                t[i]:=q[r];
                        end;
                end;
                inc(r);q[r]:=i;
        end;
        writeln(f[n]+int64(a[n])*d);
        i:=n;
        while i>0 do
        begin
                inc(rr);
                b[rr]:=i;
                i:=t[i];
        end;
        write(a[1],' ');
        for i:=rr-1 downto 1 do
                if a[b[i]]<a[b[i+1]] then
                        for j:=b[i+1]+1 to b[i] do write(a[b[i]],' ')
                else
                begin
                        for j:=b[i+1]+1 to b[i]-1 do write(a[b[i+1]],' ');
                        write(a[b[i]],' ');
                end;
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.


