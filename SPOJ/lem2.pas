const   ginp='ss.inp';
        gout='ss.out';
        maxbit=1048576;

var     gi,go:text;
        n,b,a:longint;
        ok:boolean;
        sd:array[1..20] of longint;
        d:array[1..20,1..20] of longint;
        q,f:array[0..maxbit] of longint;

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
var     i,j,vt,x:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,vt);
        for i:=1 to n do
        begin
                read(gi,sd[i]);
                for j:=1 to sd[i] do read(gi,d[i,j]);
                readln(gi);
        end;
        a:=0;b:=0;
        for i:=1 to n do
        begin
                read(gi,x);
                setbit(x,i,a);
                if i=vt then setbit(1,i,b);
        end;
end;

procedure process;
var     i,l,r,j,tm,u:longint;
begin
        ok:=true;
        l:=0;r:=1;
        q[1]:=a;f[a]:=1;
        repeat
                inc(l);
                for i:=1 to 20 do
                begin
                        u:=q[l];
                        setbit(1,i,u);
                        for j:=1 to sd[i] do
                        begin
                                tm:=getbit(d[i,j],u);
                                tm:=not(tm);
                                setbit(tm,d[i,j],u);
                        end;
                        if f[u]=0 then
                        begin
                                inc(r);
                                f[u]:=f[q[l]]+1;
                                q[r]:=u;
                        end;
                        if f[b]<>0 then exit;
                end;
        until l>=r;
        ok:=false;
end;

procedure output;
begin
        if ok then write(go,f[b]-1) else write(go,-1);
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.
