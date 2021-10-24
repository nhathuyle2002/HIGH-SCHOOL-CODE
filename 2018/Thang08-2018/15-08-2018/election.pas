const   ginp='election.inp';
        gout='election.out';

var     n,ns,sum,cou:longint;
        a,b,v:array[0..1010] of longint;
        d:array[0..1000010] of longint;

procedure sort(l,r:longint);
var     i,j,t,tm:longint;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=a[random(r-l+1)+l];
        repeat
                while a[i]>t do inc(i);
                while a[j]<t do dec(j);
                if i<=j then
                begin
                        tm:=a[i];a[i]:=a[j];a[j]:=tm;
                        tm:=v[i];v[i]:=v[j];v[j]:=tm;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure enter;
var     i:longint;
begin
        readln(n);
        for i:=1 to n do
        begin
                read(a[i]);
                v[i]:=i;
                inc(sum,a[i]);
        end;
        sort(1,n);
        ns:=sum div 2;//+sum mod 2;
end;

function min(x,y:longint):longint;
begin
        if x<y then exit(x) else exit(y);
end;

procedure process;
var     i,s:longint;
begin
        for i:=1 to sum do d[i]:=-1;
        for i:=1 to n do
                if a[i]<>0 then
                for s:=min(sum,ns+a[i]) downto a[i] do
                        if (d[s]=-1) and (d[s-a[i]]<>-1) then d[s]:=i;
        for i:=sum downto 0 do
                if d[i]<>-1 then break;
        cou:=0;
        while d[i]>0 do
        begin
                inc(cou);
                b[cou]:=v[d[i]];
                i:=i-a[d[i]];
        end;
        writeln(cou);
        for i:=cou downto 1 do write(b[i],' ');
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
