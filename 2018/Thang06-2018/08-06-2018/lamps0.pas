const   ginp='lamps.inp';
        gout='lamps.out';

var     gi,go:text;
        luu:array[0..16] of longint;
        d:array[0..16] of boolean;
        n:longint;

function db(k,x:longint):longint;
var     t:longint;
begin
        t:=(x shr (k-1)) and 1;
        if t=0 then t:=1 else t:=0;
        if t=1 then db:=x or (1 shl (k-1))
        else db:=x and (not (1 shl(k-1)));
end;

procedure dfs(x:longint);
var     i:longint;
begin
        if x=15 then
        begin
                write(go,n,' ');
                for i:=1 to n do write(go,luu[i],' ');
                close(gi);close(go);
                halt;
        end;
        if d[x]=false then exit;
        d[x]:=false;
        x:=(not x) and 15;
        inc(n);
        luu[n]:=1;dfs(db(2,x));
        luu[n]:=2;dfs(db(1,x));
        luu[n]:=3;dfs(db(4,x));
        luu[n]:=4;dfs(db(3,x));
        dec(n);
end;

procedure main;
var     i,chd,x:longint;
begin
        for i:=1 to 5 do readln(gi);
        chd:=0;
        for i:=3 downto 0 do
        begin
                read(gi,x);
                chd:=chd+x shl i;
        end;
        fillchar(d,sizeof(d),true);
        dfs(chd);
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        main;
        write(go,-1);
        close(gi);close(go);
end.
