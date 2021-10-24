const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;

function check(l,r,s:longint):boolean;
begin
        if (s>r) or (s<l) or (s=r-2) or (s=l+2) then exit(false);
        exit(true);
end;

procedure dfs(l,r,s,n:longint);
begin
        if n=1 then
        begin
                write(go,'1');
                exit;
        end;
        if check(l+n,r-n,s-n) then
        begin
                dfs(l+n,r-n,s-n,n-1);
                write(go,'+',n);
        end else
        if check(l+n,r-n,s+n) then
        begin
                dfs(l+n,r-n,s+n,n-1);
                write(go,'-',n);
        end else
        begin
                write(go,'Impossible');
                close(gi);close(go);
                halt;
        end;
end;

procedure main;
var     l,r,n,s:longint;
begin
        read(gi,n,s);
        r:=(n+1)*n div 2;
        l:=2-r;
        if ((r+s) mod 2=1) or (check(l,r,s)=false) then write(go,'Impossible')
        else dfs(l,r,s,n);
end;

begin
        assign(gi,ginp);reset(gi);
        assign(go,gout);rewrite(go);
        main;
        close(gi);close(go);
end.
