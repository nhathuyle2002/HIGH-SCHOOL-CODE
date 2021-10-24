const   ginp='gamefun.inp';
        gout='gamefun.out';

var     gi,go:text;
        d:array[1..9] of boolean;
        r1,r2,c1,c2,d1,d2:longint;
        x:array[1..4] of longint;

procedure dfs(i:longint);
var     j:longint;
begin
        if i=5 then
        begin
                if (x[1]+x[2]<>r1) or (x[3]+x[4]<>r2) or (x[1]+x[3]<>c1) or (x[2]+x[4]<>c2)
                or (x[1]+x[4]<>d1) or (x[2]+x[3]<>d2) then exit;
                writeln(go,x[1],' ',x[2]);
                write(go,x[3],' ',x[4]);
                close(gi);close(go);
                halt;
        end;
        for j:=1 to 9 do
                if d[j] then
                begin
                        d[j]:=false;
                        x[i]:=j;
                        dfs(i+1);
                        d[j]:=true;
                end;
end;

procedure main;
begin
        assign(Gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,r1,r2);
        readln(gi,c1,c2);
        read(gi,d1,d2);
        fillchar(d,sizeof(d),true);
        dfs(1);
        write(go,-1);
        close(gi);close(go);
end;

begin
        main;
end.
