function posturesN = cambiar_pos_m(posturas,nuev,orig)

    posturesN = posturas;
    nuevos = posturesN(:,nuev);
    originales = posturesN(:,orig);
    posturesN(:,nuev) = originales;
    posturesN(:,orig) = nuevos;

end