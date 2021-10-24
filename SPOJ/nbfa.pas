const   ginp='';
        gout='';

var     gi,go:text;
        s:ansistring;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        read(gi,s);
        while s[1]=' ' do delete(s,1,1);
        while s[length(s)]=' ' do delete(s,length(s),1);
        write(go,ord(s[1])+ord(s[2])-96);
        close(gi);close(go);
end.