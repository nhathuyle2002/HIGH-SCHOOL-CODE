const   ginp='';
        gout='';

var     gi,go:text;
        k,ans,tm:qword;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,k);
        tm:=trunc(sqrt(k));ans:=k+tm;
        if sqr(tm+1)<=ans then inc(ans);
        write(go,ans);
        close(gi);close(go);
end.