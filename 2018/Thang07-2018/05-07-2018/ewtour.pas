const   ginp='ewtour.inp';
        gout='ewtour.out';

var     n:longint;
        d,f,t:array[0..201,0..201] of longint;

procedure swap(var x,y:longint); inline;
var     tm:longint;
begin
        tm:=x;x:=y;y:=tm;
end;

procedure enter;
var     i,x,y,m:longint;
begin
        readln(n,m);
        for i:=1 to m do
        begin
                readln(x,y);
                if x>y then swap(x,y);
                inc(d[x,0]);
                d[x,d[x,0]]:=y;
        end;
end;

procedure process;
var     i,j,u,v,ii,jj:longint;
begin
        f[1,1]:=1;
        for i:=1 to n do
        for j:=1 to n do
        if f[i,j]>0 then
        begin
                for ii:=1 to d[i,0] do
                begin
                        u:=d[i,ii];
                        if ((u>j) or (u=n)) and (f[u,j]<f[i,j]+1) then
                        begin
                                f[u,j]:=f[i,j]+1;
                                t[u,j]:=i;
                        end;
                end;
                for jj:=1 to d[j,0] do
                begin
                        v:=d[j,jj];
                        if ((v>i) or (v=n)) and (f[i,v]<f[i,j]+1) then
                        begin
                                f[i,v]:=f[i,j]+1;
                                t[i,v]:=-j;
                        end;
                end;
        end;
end;

procedure result;
var     u,v,tp,tq,i:longint;
        p,q:array[0..201] of longint;
begin
        if f[n,n]=0 then write(-1) else
        begin
                writeln(f[n,n]-1);
                u:=n;v:=n;
                tp:=0;tq:=0;
                repeat
                        if t[u,v]>=0 then
                        begin
                                inc(tp);p[tp]:=u;
                                u:=t[u,v];
                        end else
                        begin
                                inc(tq);q[tq]:=v;
                                v:=-t[u,v];
                        end;
                until (u=0);
                for i:=tp downto 1 do write(p[i],' ');
                for i:=2 to tq do write(q[i],' ');
                write(1);
        end;
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        result;
        close(input);close(output);
end.

