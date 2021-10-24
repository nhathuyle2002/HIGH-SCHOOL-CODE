const   ginp='ss.inp';
        gout='ss.out';
        maxb=65536;
        h:array[1..4] of longint=(-1,4,-4,1);

var     gi,go:text;
        n:longint;
        a,b:longint;
        sd:array[1..16] of longint;
        d:array[1..16,1..4] of longint;
        q,c:array[0..maxb+100] of longint;

function getbit(k,x:longint):longint;
begin
        getbit:=(x shr (k-1)) and 1;
end;

procedure setbit(t,k:longint;var x:longint);
begin
        if t=1 then x:=x or (1 shl(k-1))
        else x:=x and (not(1 shl(k-1)));
end;

procedure input;
var     i:longint;
        x:char;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        a:=0;b:=0;
        for i:=1 to 16 do
        begin
                read(gi,x);
                if x='1' then setbit(1,i,a);
                if i and 3=0 then readln(gi);
        end;
        for i:=1 to 16 do
        begin
                read(gi,x);
                if x='1' then setbit(1,i,b);
                if i and 3=0 then readln(gi);
        end;
end;

procedure create;
var     i,j,da,cu,tm:longint;
begin
        for i:=1 to 16 do
        begin
                da:=1;cu:=4;
                if i and 3=0 then cu:=3;
                if i and 3=1 then da:=2;
                for j:=da to cu do
                begin
                        tm:=i+h[j];
                        if (tm>=1) and (tm<=16) then
                        begin
                                inc(sd[i]);
                                d[i,sd[i]]:=tm;
                        end;
                end;
        end;
end;

function gt(i,x:longint):longint;
begin
        if getbit(i,x)=1 then exit(254);
        gt:=x;
        setbit(1,i,gt);
end;

procedure process;
var     i,u,j,l,r,tm:longint;
begin
        l:=0;r:=1;
        c[254]:=-1;
        q[1]:=a;c[a]:=1;
        repeat
                inc(l);
                for i:=1 to 16 do
                        if getbit(i,q[l])=1 then
                        begin
                                u:=q[l];
                                setbit(0,i,u);
                                for j:=1 to sd[i] do
                                begin
                                        tm:=gt(d[i,j],u);
                                        if c[tm]=0 then
                                        begin
                                                inc(r);
                                                q[r]:=tm;
                                                c[tm]:=c[q[l]]+1;
                                        end;
                                        if c[b]<>0 then exit;
                                end;
                        end;
        until l>=r;
end;

procedure output;
begin
        write(go,c[b]-1);
        close(gi);close(go);
end;

begin
        input;
        create;
        process;
        output;
end.
